import UIKit

class BasicTableViewController: UITableViewController {
    var tableData = [String]()
    var selectedCellIndexPath: NSIndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        for i in 1...100 {
            tableData.append("Row \(i)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = tableData[indexPath.row]
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let selectedCellIndexPath = selectedCellIndexPath {
            if selectedCellIndexPath == indexPath {
                self.selectedCellIndexPath = nil
                hideDrawer(tableView, indexPath: indexPath)
            } else {
                hideDrawer(tableView, indexPath: selectedCellIndexPath)
                self.selectedCellIndexPath = indexPath
                revealDrawer(tableView, indexPath: indexPath)
            }
        } else {
            self.selectedCellIndexPath = indexPath
            revealDrawer(tableView, indexPath: indexPath)
        }
    }
    
    func revealDrawer(tableView: UITableView, indexPath:NSIndexPath) {
        let c = tableView.cellForRowAtIndexPath(indexPath)
        let drawer = UIView()
        let drawerColor = self.view.backgroundColor
        let viewwidth = c?.frame.width
        let drawerwidth = viewwidth! * 0.90
        let drawerClosedHeight = (c?.frame.height)!
        let drawerOpenHeight = (c?.frame.height)! * 1.25
        let xpos = (viewwidth! - drawerwidth)/2
        drawer.backgroundColor = drawerColor
        drawer.tag = 1
        drawer.frame = CGRect(x: xpos, y: (c?.frame.origin.y)!, width: drawerwidth, height: drawerClosedHeight)
        drawer.layer.borderColor = UIColor.blackColor().CGColor
        drawer.layer.borderWidth = 1
        c?.superview?.insertSubview(drawer, belowSubview: c!) // <--- THIS IS THE KEY 
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            drawer.frame = CGRect(x: xpos, y: (c?.frame.origin.y)! + ((c?.frame.height)! - 5), width: drawerwidth, height: drawerOpenHeight)
            drawer.layer.shadowColor = UIColor.blackColor().CGColor
            drawer.layer.shadowOffset = CGSize(width: 0, height: 10)
            drawer.layer.shadowOpacity = 0.4
            drawer.layer.shadowRadius = 5
            }, completion: nil)
    }
    
    func hideDrawer(tableView: UITableView, indexPath:NSIndexPath) {
        let c = tableView.cellForRowAtIndexPath(indexPath)
        let drawer = tableView.viewWithTag(1)!
        let viewwidth = c?.frame.width
        let drawerwidth = viewwidth! * 0.90
        let drawerClosedHeight = (c?.frame.height)!
        //let xpos = (viewwidth! - drawerwidth)/2
        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            drawer.frame = CGRect(x: drawer.frame.origin.x, y: (drawer.frame.origin.y - (c?.frame.height)! + 5), width: drawerwidth, height: drawerClosedHeight)
            }, completion: { finished in
                if finished {
                    drawer.removeFromSuperview()
                }
        })
        
    }
}
